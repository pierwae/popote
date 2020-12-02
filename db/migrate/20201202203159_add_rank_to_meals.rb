class AddRankToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :rank, :integer
  end
end
