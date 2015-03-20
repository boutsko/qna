require 'rails_helper'

feature 'View questions and answers', %q{
to find neccessary information
as a visitor of the resource
I can view a list of questions 
and for a question I can see provided answers
} do


  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'A visitor can see all questions' do

    visit questions_path

    save_and_open_page
    expect(page).to have_content 'MyString'

  end

  # scenario 'A visitor can see all answers for a question' do

  #   visit  question_answer_path

  #   expect(page).to have_content 'MyText'

  # end
end
