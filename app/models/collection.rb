class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy

  attr_accessible :name, :description, :tag_list

  acts_as_taggable
  acts_as_followable

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :tag_list
end