class IssueType < ActiveRecord::Base	
	has_many :tickets, :class_name => 'Ticket', foreign_key: 'issue_type_id'
	validates :name, presence: true
end
