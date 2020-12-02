class AddRankToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :rank, :integer
  end
end
