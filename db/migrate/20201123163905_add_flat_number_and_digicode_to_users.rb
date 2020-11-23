class AddFlatNumberAndDigicodeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :flat_number, :string
    add_column :users, :digicode, :string
  end
end
