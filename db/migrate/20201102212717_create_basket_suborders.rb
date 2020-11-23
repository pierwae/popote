class CreateBasketSuborders < ActiveRecord::Migration[6.0]
  def change
    create_table :basket_suborders do |t|
      t.references :meal, null: false, foreign_key: true
      t.references :basket, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
