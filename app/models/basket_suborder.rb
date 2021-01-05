class BasketSuborder < ApplicationRecord
  belongs_to :meal
  belongs_to :basket

  def total_price
    quantity * meal.price
  end

  def formatted_total_price
    formatted(total_price)
  end

  private

  def formatted(price)
    ('%.2f' % price).gsub('.', ',')
  end
end
