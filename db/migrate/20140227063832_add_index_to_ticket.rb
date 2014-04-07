class AddIndexToTicket < ActiveRecord::Migration
  def change
  	add_index :tickets, :reported_by
  	add_index :tickets, :assigned_to
  end
end
