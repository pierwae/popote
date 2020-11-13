class Basket < ApplicationRecord
  has_many :suborders
  has_many :orders
  has_many :meals, through: :suborders

  def formatted_total_price
    total_price = 0.0
    suborders.each do |suborder|
      total_price += suborder.total_price
    end

    ('%.2f' % total_price).gsub('.', ',')
  end
end
