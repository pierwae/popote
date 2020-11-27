class MealsController < ApplicationController
  def details
    meal = Meal.find(params[:meal_id])
    render json: meal.to_json
  end

  def presence_checking
    basket = Basket.find(params[:basket_id])
    meal   = Meal.find(params[:meal_id])
    if basket.meals.include?(meal)
      render json: BasketSuborder.where(meal: meal, basket: basket).first.id.to_json
    else
      render json: 0.to_json
    end
  end

  def update
    @meal = Meal.find(params[:id])
    meal_details = params.require(:meal).permit(:name, :information, :description, :price, :category_id)
    @meal.update(name: meal_details[:name],
                 information: meal_details[:information],
                 description: meal_details[:description],
                 price: meal_details[:price].gsub(',', '.').to_f,
                 category_id: meal_details[:category_id])
    @meal.save

    @meal.ingredients.each do |ingredient|
      ingredient.destroy
    end

    if params[:meal].keys.include?('ingredients')
      @ingredients = params.require(:meal).require(:ingredients).permit!
      @ingredients = @ingredients.to_h.sort_by { |_, value| value['rank'] }
      @ingredients.each_with_index do |item, index|
        name = item[1]['name']
        unless name.empty?
          ingredient = Ingredient.new(meal: @meal, rank: index + 1, name: name)
          ingredient.save
        end
      end
    end
    redirect_back(fallback_location: homepage_path)
  end

end
