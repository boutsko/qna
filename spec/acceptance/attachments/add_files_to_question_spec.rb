require 'acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate my question
  As a question's author
  I'd like to be able to attach files
}  do

  given(:user) { create(:user) }
  given!(:question) { build(:question) }
  given(:files) { Array[ "spec_helper.rb", "rails_helper.rb" ] }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question', js: true do

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'
    sleep 1
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end 

  scenario 'User adds files when asks question', js: true do

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'

    click_on "Add file to question"

    inputs = all('input[type="file"]')

    2.times { |n| inputs[n].set("#{Rails.root}/spec/#{files[n]}") }

    click_on 'Create'

    # 2.times { |n| expect(page).to have_link files[n], href: "/uploads/attachment/file/#{n+1}/#{files[n]}"}

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    
  end
  scenario 'User adds and removes file when asks question', js: true do

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Delete File'
    click_on 'Create'
    expect(page).to_not have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

end
