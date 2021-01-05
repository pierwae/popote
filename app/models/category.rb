class Category < ApplicationRecord
  belongs_to :cook
  has_many   :meals

  include ChildrenRanksConcern
end
