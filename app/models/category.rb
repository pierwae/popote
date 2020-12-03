class Category < ApplicationRecord
  belongs_to :cook
  has_many   :meals

  def meal_ranks_array(action)
    meal_ranks = []
    (1..meals.count).each do |rank|
      meal_ranks << rank.to_s + '.'
    end
    meal_ranks << (meals.count + 1).to_s + '.' if action == 'new'
    meal_ranks
  end
end
