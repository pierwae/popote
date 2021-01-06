class AddFirstNameAndLastNameToCooks < ActiveRecord::Migration[6.0]
  def change
    add_column :cooks, :first_name, :string
    add_column :cooks, :last_name, :string
  end
end
