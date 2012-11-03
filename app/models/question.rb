class Question < ActiveRecord::Base
  belongs_to :user

  attr_accessible :answer, :question, :title, :tag_list

  acts_as_taggable

  validates_presence_of :title
  validates_presence_of :question
  validates_presence_of :answer
  validates_presence_of :tag_list
end