requrei 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As author of ansser
  I'd like to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:author) { create(:user) }
  given!(:question) { create(:question, user: author) }
  given(:answer) { create(:answer, question: question) }

  scenario 'Unauthenticated user tries to edit question'
  scenario 'Athenticated user tries to edit question'
  scenario 'thenticated user tries to edit question other user\'s question'
end

