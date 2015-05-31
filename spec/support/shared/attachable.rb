shared_examples_for "attachable" do

  # let(:path) { new_question_path }
  # let(:attachable) { question }



  # let(:user) { create(:user) }
  # let!(:question) { build(:question) }
  # let(:files) { Array[ "spec_helper.rb", "rails_helper.rb" ] }

  # background do
  #   sign_in(user)
  #   visit path
  # end

  scenario "User adds file when sends question", js: true do

    fill_up_form
    
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'
    sleep 1
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end 

  scenario "User adds files when sends question", js: true do

    fill_up_form
    
    click_on "Add file to question"

    inputs = all('input[type="file"]')

    2.times { |n| inputs[n].set("#{Rails.root}/spec/#{files[n]}") }

    click_on 'Create'

    # 2.times { |n| expect(page).to have_link files[n], href: "/uploads/attachment/file/#{n+1}/#{files[n]}"}

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    
  end
  scenario 'User adds and removes file when asks question', js: true do

    fill_up_form
    
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Delete File'
    click_on 'Create'
    expect(page).to_not have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

end

# def fill_up_form
#   fill_in 'Title', with: 'Test question'
#   fill_in 'Body', with: 'text text'
# end
