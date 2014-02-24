class Ticket < ActiveRecord::Base
	belongs_to :reported_by_user, :class_name => 'User',foreign_key: 'reported_by'
    belongs_to :assigned_to_user, :class_name => 'User',foreign_key: 'assigned_to'
	has_many :notes
	default_scope -> { order('created_at DESC') }
	validates :reported_by, presence: true
	validates :tittle, presence: true
	validates :description, presence: true
	validates :issue_type_id, presence:true
	validates :ticket_priority_id, presence: true
	validates :ticket_state_id, presence: true

end
