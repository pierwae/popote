class RemoveCookToUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :cook
  end
end
