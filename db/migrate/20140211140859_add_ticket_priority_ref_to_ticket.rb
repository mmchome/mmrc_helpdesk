class AddTicketPriorityRefToTicket < ActiveRecord::Migration
  def change
    add_reference :tickets, :ticket_priority
    add_reference :tickets, :ticket_state
    add_column :tickets, :description, :string
    add_column :tickets, :asigned_to, :integer

  end
end
