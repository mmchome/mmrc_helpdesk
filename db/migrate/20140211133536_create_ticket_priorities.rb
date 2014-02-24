class CreateTicketPriorities < ActiveRecord::Migration
  def change
    create_table :ticket_priorities do |t|
      t.string :name	
      t.timestamps
    end
  end
end
