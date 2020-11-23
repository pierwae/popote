class Order < ApplicationRecord
  belongs_to :cook
  belongs_to :customer
  has_many   :suborders
end
