class AddIndexToTicket < ActiveRecord::Migration
  def change
  	add_index :tickets, :reported_by
  	rename_column :tickets, :asigned_to, :assigned_to
  	add_index :tickets, :assigned_to
  end
end
