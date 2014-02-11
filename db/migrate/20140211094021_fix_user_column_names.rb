class FixUserColumnNames < ActiveRecord::Migration
  def change
  	rename_column :users, :firstName, :first_name
  	rename_column :users, :lastName, :last_name
  	rename_column :users, :phoneExt, :phone_ext
  	rename_column :users, :userName, :username
  end
end
