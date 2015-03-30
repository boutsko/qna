FactoryGirl.define do
  factory :question do
    title "QuestionTitle"
    body "QuestionBody"
    user
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
