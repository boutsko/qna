class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  has_many :answers
end
