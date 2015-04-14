# coding: utf-8
require 'acceptance_helper'

feature 'Author deletes attached to answer files', %q{
  to correct set of files
  as author of answer
  I can delete earlier attached files
}, type: :feature, js: true do

  given!(:author) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question, user: author) }
  given!(:files) { create_list(:attachment, 2, attachable: answer) }
  
  background do
  end

  scenario 'Author deletes files added to answer' do
    sign_in(author)
    visit question_path(question)
    within '.answers' do
      files.each do |f|
        within "#file_#{f.id}" do
          click_on 'Delete Attachment'
          expect(page).to_not have_link 'Delete Attachment'
        end
      end
    end
  end

  scenario 'Non-author tries to delete files added to answer' do
    sign_in(other_user)
    visit question_path(question)
    within '.answers' do
      files.each do |f|
        within "#file_#{f.id}" do
          expect(page).to_not have_link 'Delete Attachment'
        end
      end
    end
  end

end
