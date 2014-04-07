class Note < ActiveRecord::Base
	belongs_to :Ticket;
	validates :ticket_id, presence: true
	validates :updateuserid, presence: true
	validates :description, presence:true
	default_scope -> { order('created_at DESC') }
end
