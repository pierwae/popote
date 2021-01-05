class CreateCooks < ActiveRecord::Migration[6.0]
  def change
    create_table :cooks do |t|
      t.references :user, null: true, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
