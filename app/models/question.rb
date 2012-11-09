class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :collection

  # TODO: fix that :user_id is not in mass_assignment-list
  attr_accessible :answer, :question, :title, :user_id

  validates_presence_of :title
  validates_presence_of :question
  validates_presence_of :answer
end