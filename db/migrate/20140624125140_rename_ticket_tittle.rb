class RenameTicketTittle < ActiveRecord::Migration
  def change
  	rename_column :tickets, :tittle, :title
  end
end
