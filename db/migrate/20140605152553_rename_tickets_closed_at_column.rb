class RenameTicketsClosedAtColumn < ActiveRecord::Migration
  def change
  	rename_column :tickets, :close_at, :closed_at
  end
end
