class Basket < ApplicationRecord
  has_many :suborders
  has_many :orders
  has_many :meals, through: :suborders
end
