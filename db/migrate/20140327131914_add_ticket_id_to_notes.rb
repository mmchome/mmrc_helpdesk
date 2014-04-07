class AddTicketIdToNotes < ActiveRecord::Migration
  def change
  	add_column :notes, :ticket_id, :integer
    add_index :notes, :ticket_id
  end
end
