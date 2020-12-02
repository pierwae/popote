class Cook < ApplicationRecord
  belongs_to :user
  has_many   :categories
  has_many   :orders

  def category_ranks_array(action)
    category_ranks = []
    (1..categories.count).each do |rank|
      category_ranks << rank.to_s + '.'
    end
    category_ranks << (categories.count + 1).to_s + '.' if action == 'new'
    category_ranks
  end

  # def update_category_ranks
  #   i = 0
  #   categories.order(:rank).each do |category|
  #     i += 1
  #     category.rank = i
  #     category.save
  #   end
  # end
end
