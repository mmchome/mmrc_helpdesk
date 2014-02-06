class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.boolean :isAssigned
      t.timestamps :timeOpened
      t.string :tittle


      t.timestamps
    end
  end
end
