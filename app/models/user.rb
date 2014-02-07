class User < ActiveRecord::Base
	attr_accessor :username, :name, :email

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :userName, presence: true,  length: { maximum: 50 }
	validates :firstName, presence: true,  length: { maximum: 50 }
	validates :lastName, presence: true,  length: { maximum: 50 }

	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},uniqueness: { case_sensitive: false }
	
	validates :userName, presence: true
	validates :user_types_id, presence: true

	validates :password, length: { minimum: 6 }
	has_secured_password
	before_save { self.email = email.downcase }
end