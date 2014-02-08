class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	#attr_accessor :userName, :email


	validates :userName, presence: true,  length: { maximum: 50 }
	validates :firstName, presence: true,  length: { maximum: 50 }
	validates :lastName, presence: true,  length: { maximum: 50 }

	#validates :name, presence: true, length: { maximum: 50 }
  	
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

	#validates :user_types_id, presence: true

	validates :password, length: { minimum: 6 }
	has_secure_password
	
end