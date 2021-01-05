class Cook < ApplicationRecord
  belongs_to :user
  has_many   :categories
  has_many   :orders
  has_many   :meals

  include ChildrenRanksConcern
end
