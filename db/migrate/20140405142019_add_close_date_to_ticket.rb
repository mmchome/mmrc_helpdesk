class AddCloseDateToTicket < ActiveRecord::Migration
  def change
  	add_column :tickets, :close_at, :datetime
  end
end
