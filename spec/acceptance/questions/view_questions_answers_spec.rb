require 'rails_helper'

feature 'View questions and answers', %q{
to find neccessary information
as a visitor of the resource
I can view a list of questions 
and for a question I can see provided answers
} do

  
  given!(:user) { create(:user) }
  # given!(:question) { create(:question, user: user) }
  given!(:question) { create(:question, title: "question 1 title", body: "question 1 body",  user: user) }
  # given!(:answer) { create(:answer, question: question) }

  scenario 'A visitor can see all questions' do

    # create(:question, title: question1_title, user: user)
    create(:question, title: 'question 2 title', user: user)

    visit questions_path
    expect(page).to have_content 'question 1 title'
    expect(page).to have_content 'question 2 title'
  end


  scenario 'A visitor can see all answers for a question', js: true do

    question.answers.create!([{body: 'answer 1 loaded', user: user}, {body: 'answer 2 loaded', user: user}])
    visit question_path(question)
    expect(page).to have_content 'question 1 title'
    expect(page).to have_content 'answer 1'
    expect(page).to have_content 'answer 2'
  end

  scenario 'Visitor can\'t answer question' do
    question.answers.create!([{body: 'answer 1 loaded', user: user}, {body: 'answer 2 loaded', user: user}])
    visit question_path(question)
    expect(page).to_not have_content 'Your'
  end
end
