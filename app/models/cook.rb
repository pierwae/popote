class Cook < ApplicationRecord
  belongs_to :user
  has_many   :categories
  has_many   :orders
  has_many   :meals

  def category_ranks_array(action)
    category_ranks = []
    (1..categories.count).each do |rank|
      category_ranks << rank.to_s + '.'
    end
    category_ranks << (categories.count + 1).to_s + '.' if action == 'new'
    category_ranks
  end

  def check_category_ranks
    i = 1
    categories.order(:rank).each do |category|
      category.update(rank: i) if category.rank != i
      i += 1
    end
  end
end
