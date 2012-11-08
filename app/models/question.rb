class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :collection

  # TODO: fiy that :user_id is not in mass_assign-list
  attr_accessible :answer, :question, :title, :tag_list, :user_id

  acts_as_taggable

  validates_presence_of :title
  validates_presence_of :question
  validates_presence_of :answer
  validates_presence_of :tag_list
end