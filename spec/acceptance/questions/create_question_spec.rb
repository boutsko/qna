require 'rails_helper'

feature 'Ask question', %q{
  to receive a piece of wisdom form the comunity 
  as an authorized member of QnA
  I can ask a question
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    click_on 'Create'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'text text'
  end

  scenario 'Non-authenticated user tries to create question' do
    visit questions_path
    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
