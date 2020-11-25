class AddInformationToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :information, :string
  end
end
