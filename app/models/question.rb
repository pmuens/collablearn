class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :collection

  # TODO: fix that :user_id is not in mass_assignment-list
  attr_accessible :answer, :question, :title, :user_id

  validates :title, presence: true, length: { in: 1..50 }
  validates :question, presence: true#, length: { in: 1..500 }
  validates :answer, presence: true#, length: { in: 1..500 }
end