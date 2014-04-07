class TicketPriority < ActiveRecord::Base
	has_many :tickets, :class_name => 'Ticket', foreign_key: 'ticket_priority_id'	
end
