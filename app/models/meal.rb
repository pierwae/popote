class Meal < ApplicationRecord
  belongs_to :category
  has_many   :basket_suborders
  has_many   :suborders


  def formatted_price
    ('%.2f' % price).gsub('.', ',')
  end
end
