require 'acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate my question
  As a question's author
  I'd like to be able to attach files
}  do

  given(:user) {create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file whsen asks question' do

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    # click_on 'Choose File'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    sleep 3
    click_on 'Add'
    # save_and_open_page

    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Create'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    
  end 
end
