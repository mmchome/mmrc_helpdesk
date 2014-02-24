class FixCamecasecolumns< ActiveRecord::Migration
  def change
  	rename_column :tickets, :isAssigned, :is_assigned
  	rename_column :notes, :updateUserId, :updateuserid
  	rename_column :notes, :isSolution, :is_solution

  	create_table :ticket_priority do |t|
      t.string :name

      t.timestamps
    end
  end
end
