class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :userName
      t.integer :phoneExt
      t.string :location
      

      t.timestamps
    end
  end
end
