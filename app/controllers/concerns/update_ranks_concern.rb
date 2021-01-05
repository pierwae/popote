module UpdateRanksConcern
  extend ActiveSupport::Concern

  def update_ranks(selected_element, new_rank, old_rank)
    siblings = siblings(selected_element)
    if new_rank > old_rank
      moving_elements = siblings.where(rank: (old_rank + 1..new_rank).to_a)
      moving_elements.each { |element| element.decrement!(:rank) }
    elsif new_rank < old_rank
      moving_elements = siblings.where(rank: (new_rank...old_rank).to_a)
      moving_elements.each { |element| element.increment!(:rank) }
    end
    selected_element.update(rank: new_rank)
    selected_element.send(parent(selected_element)).check_children_ranks
  end

  private

  def siblings(selected_element)
    case selected_element.class.name
    when 'Category' then selected_element.cook.categories
    when 'Meal' then selected_element.category.meals
    end
  end

  def parent(selected_element)
    case selected_element.class.name
    when 'Category' then 'cook'
    when 'Meal' then 'category'
    end
  end
end
