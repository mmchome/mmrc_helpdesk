class Ticket < ActiveRecord::Base
	include ActiveModel::Dirty
	belongs_to :assigned_to_user, :class_name => 'User',foreign_key: 'assigned_to'
	belongs_to :reported_by_user, :class_name => 'User',foreign_key: 'reported_by'
  belongs_to :priority, :class_name => 'TicketPriority', foreign_key: 'ticket_priority_id'
	belongs_to :issue_type, :class_name => 'IssueType', foreign_key: 'issue_type_id'
	belongs_to :state, :class_name => 'TicketState', foreign_key: 'ticket_state_id'
	has_many :notes,  dependent: :destroy
	
	#default_scope -> { order('created_at DESC') } 
	#since use a sortable table disable above else causes conflict

	validates :reported_by, presence: true
	validates :title, presence: true
	validates :description, presence: true
	validates :issue_type_id, presence:true
	validates :ticket_priority_id, presence: true
	validates :ticket_state_id, presence: true

	def assigned?(to_user)
	  	tickets.find_by(assigned_to: to_user.id)
	end
  def assigned?
    return assigned_to?
  end

	def reported?(to_user)
	  	tickets.find_by(reported_by: to_user.id)
	end

	def self.search(search)
		 if search
        if(search.to_i!=0)
          where (['id =?', search])
        else
          if(search.size >1)
            search_condition = "%" + search[1..-1] + "%"
          else
            search_condition = "%" + search + "%"
          end
          joins(:issue_type, :state, :priority).
          where("title LIKE ? OR description LIKE ? OR issue_types.name LIKE ? OR ticket_states.name LIKE ? OR ticket_priorities.name LIKE ?",
                search_condition,search_condition,search_condition,search_condition,search_condition)
        end
  		else
    		scoped
    	end
  	end

  	def issue_type_name
  		issue_type.name
  	end

  	def priority_name
  		priority.name
  	end

  	def state_name
  		state.name
  	end

  	def reported_name
  		reported_by_user.username
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
