class RenameTicketPriorityToTicketPriorities < ActiveRecord::Migration
  def change
  	 drop_table  :ticket_priority
  end
end
