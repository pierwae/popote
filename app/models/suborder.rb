class Suborder < ApplicationRecord
  belongs_to :meal
  belongs_to :basket

  def total_price
    quantity * meal.price
  end

  def formatted_total_price
    ('%.2f' % total_price).gsub('.', ',')
  end
end
