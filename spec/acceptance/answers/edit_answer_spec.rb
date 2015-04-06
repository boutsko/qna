require 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As author of answer
  I'd like to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:author) { create(:user) }
  # given!(:question) { create(:question, user: author) }
  # given!(:answer) { create(:answer, question: question) }

  # scenario 'Unauthenticated user tries to edit question' do

  #   visit  question_path(question)
  #   expect(page).to_not have_link 'Edit'
  # end  

  describe "Authenticated user" do

    before do
      sign_in author
      question1 = create(:question, user: author) 
      answer = create(:answer, question: question1) 
      visit question_path(question1)
    end

    scenario 'sees link to Edit' do

      # puts current_user
      # puts "hello: #{answer.user_id}"
      # puts current_user.id
      
      save_and_open_page
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'tries to edit his answer' do
      click_on 'Edit'
      within '.answers' do
        fill_in 'Answer', with: 'edited answer'
      end
      click_on 'Save'

      expect(page).to_not have_content answer.body
      expect(page).to have_content 'edited answer'
      expect(page).to_not have_selector 'textarea'
    end
    
    scenario 'tries to edit other user\'s question' do
    end 
  end
end
