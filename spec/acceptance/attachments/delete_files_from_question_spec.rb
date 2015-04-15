# coding: utf-8
require 'acceptance_helper'

feature 'Author deletes attached files', %q{
  to correct set of files
  as author of question/anser
  I can delete files earlier attached
}, type: :feature, js: true do

  given!(:author) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: author) }
  given!(:files) { create_list(:attachment, 2, attachable: question) }
  
  background do
  end

  scenario 'Author deletes files added to question' do
    sign_in(author)
    visit questions_path

    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    
    click_on 'Create'
    within '.question-container' do
      expect(page).to have_link 'spec_helper.rb'
      click_on 'Delete Attachment'
      expect(page).to_not have_link 'spec_helper.rb'
    end
  end

  scenario 'Non-author tries to delete files added to question' do
    sign_in(other_user)
    visit question_path(question)

    within '.question-container' do
      files.each do |f|
        within "#file_#{f.id}" do
          expect(page).to_not have_link 'Delete Attachment'
        end
      end
    end
  end

end
