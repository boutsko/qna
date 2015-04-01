require 'rails_helper'

feature 'Answer a question', %q{
  to share my knowlege of a subject
  as an authorized member of QnA
  I can answer a question
} do

  given!(:user) { create(:user) }
  given!(:author) { create(:user) }
  given!(:question) { create_list(:question, 2, user: author) }

  scenario 'Authorized user answers a question created by other user', js: true do 

    sign_in(user)

    visit question_path(question)

    fill_in 'Your answer', with: 'first answer text'
    click_on 'Create Answer'
    within '.answers' do
      expect(page).to have_content 'first answer text'
    end
  end

  scenario 'Guest can\'t answer questons' do  
    visit questions_path
    expect(page).to_not have_content 'Create Answer'
  end 
end
