class Basket < ApplicationRecord
  belongs_to :customer, class_name: 'User'
  has_many   :orders
end
