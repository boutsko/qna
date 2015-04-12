require 'acceptance_helper'

feature 'Best Answer', %q{
  As author of question
  I would like
  to mark best answer of all.
} do

  given!(:author) { create(:user) }
  given!(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question, user: author) }

  given!(:non_author) { create(:user) }
  
  describe "Author of question" do

    before do
      sign_in author
      visit question_path(question)
    end
    
    scenario "marks an answer as the best one", js: true do
      click_on "Best"
      within "#answer_#{answer.id}" do
        expect(page).to have_content("The best answer!", count: 1)
      end
    end
  end
  
  describe "Non-author of question" do
    before do
      sign_in non_author
    end
    
    scenario "can't mark an answer as the best" do
      expect(page).to_not have_content "Best Question"
    end
  end

end
