require 'acceptance_helper'

feature 'User can vote', %q{
  To like a question
  As a registered user
  I'd like to vote for it
} do

scenario 'User can vote for question/answer'
scenario 'User can not vote for his question/answer'
scenario 'User can vote for question/answer only once'
scenario 'User can cancel his vote and re-vote'
scenario 'Question/answer has raiting'
