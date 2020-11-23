class CreateSuborders < ActiveRecord::Migration[6.0]
  def change
    create_table :suborders do |t|
      t.references :meal, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
