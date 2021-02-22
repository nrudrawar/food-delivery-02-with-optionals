require_relative "base_repository"
require_relative "../models/meal"

class MealRepository < BaseRepository
  def update(index, name, price)
    element = @elements[index]
    element.name = name
    element.price = price
    save_csv
  end

  private

  def build_headers
    %w[id name price]
  end

  def build_row(element)
    [element.id, element.name, element.price]
  end

  def build_element(row)
    row[:price] = row[:price].to_i
    Meal.new(row)
  end
end
