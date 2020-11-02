class Basket < ApplicationRecord
  has_many :suborders
  has_many :orders
end
