require_relative "../views/meals_view"
require_relative "../models/meal"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def add
    name = @meals_view.ask_user_for(:name)
    price = @meals_view.ask_user_for(:price).to_i
    meal = Meal.new(name: name, price: price)
    @meal_repository.create(meal)
    display_meals
  end

  def list
    display_meals
  end

  def edit
    display_meals
    index = @meals_view.ask_user_for(:index).to_i - 1
    name = @meals_view.ask_user_for(:name)
    price = @meals_view.ask_user_for(:price).to_i
    @meal_repository.update(index, name, price)
    display_meals
  end

  def delete
    display_meals
    index = @meals_view.ask_user_for(:index).to_i - 1
    @meal_repository.destroy(index)
  end

  private

  def display_meals
    meals = @meal_repository.all
    @meals_view.display(meals)
  end
end
