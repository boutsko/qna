require 'rails_helper'

feature 'User deletes his input', %q{
 to delete a question or answer which I created
 as a loged in user
 I should log in first
} do

#   given!(:user) { create(:user) }
#   given!(:author) { create(:user) }
#   given!(:question1) { create(:question, user: user, title: 'hello world!') }
#   given!(:question2) { create(:question, user: author, title: 'hello world!') }

#   scenario 'Authenticated user deletes question created by him' do

#     sign_in(user)
#     visit question_path(question1)
# #    click_on 'Delete Question'
# #    click_on 'Create Answer'
#     visit delete_question_path
#     save_and_open_page

#   end
#     scenario 'guest tries to delete a question created by input' do
#   end

#       scenario 'Authenticated user deletes question created by another user' do
#   end
# end



  given(:author) { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question) { create(:question, user: author) }

  scenario 'Author can delete his question' do
    author.questions << question
    sign_in author
    visit question_path(question)
    save_and_open_page
    click_on 'Delete Question'
    expect(page).to have_content I18n.t('question.destroyed')
    expect(current_path).to eq questions_path
  end
  scenario 'Users can not delete question of another user' do
    sign_in other_user
    visit question_path(question)
    click_on 'Delete Question'
    expect(page).to have_content I18n.t('question.failure.not_an_author')
    expect(current_path).to eq question_path(question)
  end
  scenario 'Guest can not delete any questions' do
    visit question_path(question)
    click_on 'Delete Question'
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end
end

