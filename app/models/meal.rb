class Meal < ApplicationRecord
  has_one_attached :photo

  belongs_to :category, optional: true
  belongs_to :cook
  has_many   :basket_suborders
  has_many   :suborders
  has_many   :ingredients

  include ChildrenRanksConcern

  def formatted_price
    puts id
    formatted(price)
  end

  private

  def formatted(price)
    ('%.2f' % price).gsub('.', ',')
  end
end
