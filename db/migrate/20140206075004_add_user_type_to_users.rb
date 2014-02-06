class AddUserTypeToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :user_types, index: true
  end
end
