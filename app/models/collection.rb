class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy

  attr_accessible :name, :description, :is_open, :tag_list

  acts_as_taggable_on :tags
  acts_as_followable

  validates :name, presence: true, length: { in: 1..50 }
  validates :description, presence: true, length: { in: 1..300 }
  validates_presence_of :tag_list
end