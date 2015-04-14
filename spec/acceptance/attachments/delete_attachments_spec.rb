require 'acceptance_helper'

feature 'Author deletes attached files', %q{
  to correct set of files
  as author of question/anser
  I can delete files earlier attached
} do

  given(:user) { create(:user) }
  given(:files) { Array[ "spec_helper.rb", "rails_helper.rb" ] }
  
  background do
    sign_in(user)
    visit questions_path
  end

  scenario 'Author deletes files added to question', js: true do
    # save_and_open_page
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    
    click_on 'Create'
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    click_on 'Delete Attachment'
    expect(page).to_not have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

    scenario 'Non-author tries to delete files added to question'
    scenario 'Author deletes files added to answer'
    scenario 'Non-author tries to delete files added to answer'
end

