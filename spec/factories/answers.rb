FactoryGirl.define do
  factory :answer do
    body "AnswerBody"
    question 
  end

  factory :invalid_answer, class: "Answer" do
    body nil
  end
end

