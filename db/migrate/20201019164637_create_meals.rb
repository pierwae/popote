class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.references :cook, null: false, foreign_key: true
      t.float :price
      t.string :name

      t.timestamps
    end
  end
end
