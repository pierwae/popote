class AddSomeColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :address, :string
    add_column :users, :zip, :string
    add_column :users, :city, :string
    add_column :users, :phone_number, :string
    add_column :users, :admin, :boolean
  end
end
