require 'rails_helper'
require 'thinking_sphinx/test'

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
    ThinkingSphinx::Test.init
    ThinkingSphinx::Test.start_with_autostop
  end

  config.include AcceptanceController, type: :feature

  config.use_transactional_fixtures = false
  
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
