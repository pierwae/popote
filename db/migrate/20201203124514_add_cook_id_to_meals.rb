class AddCookIdToMeals < ActiveRecord::Migration[6.0]
  def change
    add_reference :meals, :cook, null: true, foreign_key: true
  end
end
