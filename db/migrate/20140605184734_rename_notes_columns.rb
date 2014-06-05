class RenameNotesColumns < ActiveRecord::Migration
  def change
  	rename_column :notes,  :updateUserId, :updateuserid
  	rename_column :notes,  :isSolution , :is_solution
  end
end
