class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions, dependent: :destroy
  has_many :collections, dependent: :destroy

  attr_accessible :email, :username, :password, :password_confirmation, :name, :bio, :interest_list, :terms_of_service, :remember_me

  acts_as_tagger
  acts_as_follower

  acts_as_taggable_on :interests
  acts_as_followable

  username_regex = /\A[A-Za-z\d\-\_\.\+]+\z/

  validates_acceptance_of :terms_of_service
  validates :username, presence: true, length: { in: 1..20 }, format: { with: username_regex }, uniqueness: { case_sensitive: false }
  validates :bio, length: { in: 0..200 }
end