class AddUserRefToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :user, index: true
    add_reference :tickets, :issue_type, index: true

  end
end
