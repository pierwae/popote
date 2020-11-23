class Order < ApplicationRecord
  belongs_to :cook
  belongs_to :customer, class_name: 'User'
  has_many   :suborders
end
