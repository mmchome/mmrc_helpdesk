class AddDefaulValueToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :user_types_id, :int, :default => 3
  end
end
