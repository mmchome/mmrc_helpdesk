class TicketState < ActiveRecord::Base
	has_many :tickets, :class_name => 'Ticket', foreign_key: 'ticket_state_id'	
end
