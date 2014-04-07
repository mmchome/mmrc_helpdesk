class Ticket < ActiveRecord::Base
	include ActiveModel::Dirty

	belongs_to :reported_by_user, :class_name => 'User',foreign_key: 'reported_by'
    belongs_to :assigned_to_user, :class_name => 'User',foreign_key: 'assigned_to'
    belongs_to :priority, :class_name => 'TicketPriority', foreign_key: 'ticket_priority_id'
	belongs_to :issue_type, :class_name => 'IssueType', foreign_key: 'issue_type_id'
	belongs_to :state, :class_name => 'TicketState', foreign_key: 'ticket_state_id'
	has_many :notes,  dependent: :destroy
	
	default_scope -> { order('created_at DESC') }

	validates :reported_by, presence: true
	validates :tittle, presence: true
	validates :description, presence: true
	validates :issue_type_id, presence:true
	validates :ticket_priority_id, presence: true
	validates :ticket_state_id, presence: true

	def assigned?(to_user)
	  	tickets.find_by(assigned_to: to_user.id)
	end

	def reported?(to_user)
	  	tickets.find_by(reported_by: to_user.id)
	end

	def assign!(to_user)
	  	ticket.update(assigned_to: to_user.id)
	  	ticket.update(is_assigned: true)
	end

	def deassign!()
    	ticket.update(assigned_to: nil)
	  	ticket.update(is_assigned: false)
  	end
end
