class Order < ApplicationRecord
  belongs_to :cook
  belongs_to :basket
  belongs_to :customer
end
