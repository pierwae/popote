class CreateBaskets < ActiveRecord::Migration[6.0]
  def change
    create_table :baskets do |t|
      t.references :customer, null: false, foreign_key: { to_table: :users }
      t.string :status
      t.float :total_price

      t.timestamps
    end
  end
end
