class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :attachments, as: :attachmentable

  validates :title, :body, :user,  presence: true
  
  accepts_nested_attributes_for :attachments
end
