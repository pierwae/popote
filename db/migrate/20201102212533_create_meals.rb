class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.references :category, null: true, foreign_key: true
      t.float :price
      t.string :name
      t.boolean :deleted
      t.string :description

      t.timestamps
    end
  end
end
