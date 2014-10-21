class User < ActiveRecord::Base
  has_many :reported_by_tickets, :class_name => 'Ticket', :foreign_key => 'reported_by'
  has_many :assigned_to_tickets, :class_name => 'Ticket', :foreign_key => 'assigned_to'

  has_one :user_types
  

	before_save { self.email = email.downcase }
	before_create :create_remember_token
 


	validates :username, presence: true,  length: { maximum: 50 }
	validates :first_name, presence: true,  length: { maximum: 50 }
	validates :last_name, presence: true,  length: { maximum: 50 }
  validates :user_types_id, presence: true

  	
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

	

	validates :password, length: { minimum: 6 }, :if => :password
	has_secure_password

  def feed
    Ticket.where("ticket_state_id = ?", 1)
  end

	def User.new_remember_token
    	SecureRandom.urlsafe_base64
	end

  	def User.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end

  	private

    	def create_remember_token
      		self.remember_token = User.encrypt(User.new_remember_token)
    	end

	
end