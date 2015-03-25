require 'rails_helper'

feature 'View questions and answers', %q{
to find neccessary information
as a visitor of the resource
I can view a list of questions 
and for a question I can see provided answers
} do

  question1_title = 'question 1 title'
  question1_body  = 'question 1 body'
  question2_title = 'question 2 title'
  
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:question) { create(:question, title: question1_title, body: question1_body,  user: user) }
#  given!(:answer) { create(:answer, question: question) }

  scenario 'A visitor can see all questions' do

    #    create(:question, title: question1_title, user: user)
    create(:question, title: question2_title, user: user)

    visit questions_path
    expect(page).to have_content 'question 1 title'
    expect(page).to have_content 'question 2 title'
  end

  scenario 'A visitor can see all answers for a question' do

    question.answers.create!([{body: 'answer 1'}, {body: 'answer 2', user: user}])
    
    visit question_path(question)
    expect(page).to have_content 'question 1 title'
    expect(page).to have_content 'answer 1'
    expect(page).to have_content 'answer 2'
  end
end
