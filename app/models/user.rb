class User < ActiveRecord::Base
  attr_accessible :email, :is_blocked, :is_validated, :password, :password_confirmation, :salt, :username, :terms_of_service

  #dependent destroy --> friendships, lists

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  username_regex = /\A[A-Za-z\d\-\_\.\+]+\z/

  validates :email, presence: true, format: { with: email_regex }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { in: 6..40 }
  validates :username, presence: true, format: { with: username_regex }, uniqueness: { case_sensitive: false }
  validates_acceptance_of :terms_of_service

  before_save { |user| user.email = user.email.downcase }
  before_save :encrypt_password

  def has_password?(submitted_password)
    password == encrypt(submitted_password)
  end
  
  class << self
    def authenticate(email, submitted_password)
      user = find_by_email(email.downcase)
      (user && user.has_password?(submitted_password)) ? user : nil
    end
  
    def authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
    end
  end
  
  private
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end  
end