require 'rails_helper'

feature 'Answer a question', %q{
  to share my knowlege of a subject
  as an authorized member of QnA
  I can answer a question
} do

  given!(:user) { create(:user) }
  given!(:author) { create(:user) }
  given!(:question) { create(:question, user: author) }
  #  given!(:answer) { create(:answer, question: question) }

  scenario 'Authorized user answers a question' do

    sign_in(user)

    visit question_path(question)
    click_on 'Create Answer'
    fill_in 'body', with: 'text text'
    click_on 'Create Answer'
    expect(page).to have_content 'Answers#show'

    
  end
end


