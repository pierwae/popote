class AddRankToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :rank, :integer
  end
end
