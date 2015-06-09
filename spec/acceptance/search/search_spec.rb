require 'acceptance_helper'

feature 'User may search content', %q{
        In order to be able search content
        As an user
        I want to be able search content
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user, title: 'find me', body: 'foo') }
  given!(:answer) { create(:answer, question: question, body: 'test search') }
  given!(:comment) { create(:comment, body: 'my comment') }

  background do
	sign_in(user)
  end

  scenario 'search question', js: true do
    
    ThinkingSphinx::Test.run do
      select('Question', from: 'conditions')
      fill_in 'search', with: 'foo'
      click_on 'Search'
      
	  expect(page).to have_content  question.body
	  expect(page).to have_content  question.title
    end
  end

  scenario 'search answer', js: true do
    
    ThinkingSphinx::Test.run do
      select('Answer', from: 'conditions')
      fill_in 'search', with: 'test'
      click_on 'Search'
      
	  expect(page).to have_content  answer.body
    end
  end

  scenario 'search comment', js: true do
    
    ThinkingSphinx::Test.run do
      select('Comment', from: 'conditions')
      fill_in 'search', with: 'my comment'
      click_on 'Search'
      
	  expect(page).to have_content  comment.body
    end
  end
  
  scenario 'search all', js: true do

    ThinkingSphinx::Test.run do
      select('All', from: 'conditions')
      fill_in 'search', with: ''
      click_on 'Search'

      expect(page).to have_content  user.email
      expect(page).to have_content  question.title
      expect(page).to have_content  question.body
      expect(page).to have_content  answer.body
      expect(page).to have_content  comment.body
    end  
  end

end
