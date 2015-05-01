# coding: utf-8
require 'rails_helper'

describe Question, type: :model do
  it { should validate_presence_of :title and :body }
  it { should validate_presence_of :user }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:attachments) }
  it { should have_many :votes }
  it { should belong_to(:user) }

  it {should accept_nested_attributes_for :attachments }
end
