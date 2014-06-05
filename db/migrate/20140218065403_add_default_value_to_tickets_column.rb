class AddDefaultValueToTicketsColumn < ActiveRecord::Migration
  def change
  	add_column :tickets, :reported_by, :integer
    add_column :tickets, :is_assigned, :boolean, default:false
  end
end
