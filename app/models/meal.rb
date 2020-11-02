class Meal < ApplicationRecord
  belongs_to :category
  has_many   :suborders
end
