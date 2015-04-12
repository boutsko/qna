require 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As author of answer
  I'd like to edit my answer
} do

  given!(:author) { create(:user) }
  given!(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question, user: author) }
  
  scenario 'Unauthenticated user tries to edit question' do
    visit  question_path(question)
    expect(page).to_not have_link 'Edit'
  end  

  describe "Authenticated user" do
    before do
      sign_in author      
      visit question_path(question)
    end

    scenario 'sees link to Edit' do
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit his answer', js: true do
      click_on 'Edit'
      within '.answers' do
        fill_in 'Answer', with: 'edited answer'
        click_on 'Save'
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end
  end

  describe "Different user" do
    before do
      user1 = create(:user)
      sign_in user1
      visit question_path(question)
    end        

    scenario 'tries to edit other user\'s question', js: true do
      expect(page).to_not have_content 'Delete'
      expect(page).to_not have_content 'Edit'
    end
  end 
end

