module ChildrenRanksConcern
  extend ActiveSupport::Concern

  def children_ranks_array(*action)
    method = children_method_name

    ranks_array = []
    (1..send(method).count).each { |rank| ranks_array << rank.to_s + '.' }
    ranks_array << (send(method).count + 1).to_s + '.' if action.first == 'new'
    ranks_array
  end

  def check_children_ranks
    method = children_method_name
    i = 1
    send(method).order(:rank).each do |element|
      element.update(rank: i) if element.rank != i
      i += 1
    end
  end

  private

  def children_method_name
    case self.class.name
    when 'Cook' then 'categories'
    when 'Category' then 'meals'
    when 'Meal' then 'ingredients'
    end
  end
end
