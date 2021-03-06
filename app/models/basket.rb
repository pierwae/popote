class Basket < ApplicationRecord
  has_many :basket_suborders
  has_many :meals, through: :basket_suborders

  def formatted_total_price
    total_price = 0.0
    basket_suborders.each do |suborder|
      total_price += suborder.total_price
    end

    formatted(total_price)
  end

  private

  def formatted(price)
    ('%.2f' % price).gsub('.', ',')
  end
end
