class Question < ActiveRecord::Base
  belongs_to :user

  attr_accessible :answer, :question, :title

  validates_presence_of :title
  validates_presence_of :question
  validates_presence_of :answer
end