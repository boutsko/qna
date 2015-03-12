# coding: utf-8
require 'rails_helper'

describe Question, type: :model do
  it { should validate_presence_of :title and :body }
  it { should have_many :answers }
  it { should have_many(:answers).dependent(:destroy) }
end
