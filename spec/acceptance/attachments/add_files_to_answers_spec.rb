require 'acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As a answer's author
  I'd like to be able to attach files
}  do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:files) { Array[ "spec_helper.rb", "rails_helper.rb" ] }
  
  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds file when adds answer', js: true do
    fill_in 'Your answer', with: 'My answer'
    
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create Answer'
    sleep 1
    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end 

  scenario 'User adds several files when adds answer', js: true do
    fill_in 'Your answer', with: 'My answer'

    click_on 'Add more files'
    
    inputs = all('input[type="file"]')

    2.times { |n| inputs[n].set("#{Rails.root}/spec/#{files[n]}") }

    click_on 'Create Answer'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    end
  end

  scenario 'User adds and removes file while creating answer', js: true do

    fill_in 'Your answer', with: 'My answer'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Remove File'
    click_on 'Create Answer'
    expect(page).to_not have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

end
