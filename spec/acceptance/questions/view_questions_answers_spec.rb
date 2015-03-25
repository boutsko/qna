require 'rails_helper'

feature 'View questions and answers', %q{
to find neccessary information
as a visitor of the resource
I can view a list of questions 
and for a question I can see provided answers
} do

  question1_title = 'question title 1'
  question2_title = 'question title 2'
    
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'A visitor can see all questions' do

    create(:question, title: question1_title, user: user)
    create(:question, title: question2_title, user: user)

    visit questions_path
    expect(page).to have_content 'question title 1'
    expect(page).to have_content 'question title 2'
  end

  scenario 'A visitor can see all answers for a question' do

    visit question_path(question)
    expect(page).to have_content 'MyText'
  end
end
