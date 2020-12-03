class Meal < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :cook
  has_many   :basket_suborders
  has_many   :suborders
  has_many   :ingredients

  def formatted_price
    ('%.2f' % price).gsub('.', ',')
  end

  def ingredient_ranks_array
    ingredient_ranks = []
    (1..ingredients.count).each do |rank|
      ingredient_ranks << rank.to_s + '.'
    end
    ingredient_ranks
  end
end
