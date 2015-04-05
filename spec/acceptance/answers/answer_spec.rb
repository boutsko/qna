require 'rails_helper'

feature 'Answer question', %q{
  to share knowlege of subject
  as authorized member of QnA
  I can answer question
} do

  given!(:user) { create(:user) }
  given!(:author) { create(:user) }
  given!(:question) { create(:question, user: author) }

  scenario 'Authorized user answers question created by other user', js: true do 

    sign_in(user)

    visit question_path(question)
    fill_in 'Your answer', with: 'first answer text'
    click_on 'Create Answer'
    within '.answers' do
      expect(page).to have_content 'first answer text'
    end
    fill_in 'Your answer', with: 'second answer text'
    click_on 'Create Answer'
    within '.answers' do
      expect(page).to have_content 'first answer text'
      expect(page).to have_content 'second answer text'
    end
  end

  scenario 'Guest can\'t answer questons' do  
    visit questions_path
    expect(page).to_not have_content 'Create Answer'
  end 
end
